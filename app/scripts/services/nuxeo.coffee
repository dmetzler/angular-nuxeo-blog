
angular.module("services.nuxeo", ['ng'])
.factory("NuxeoAutomation", ['$http','$q','NUXEO_CONFIG', ($http,$q,NUXEO_CONFIG) ->   

  NuxeoAutomation = (automationChain, params) -> 


    url = [NUXEO_CONFIG.contextPath, '/site/automation/', automationChain].join('')
    params = params

    Resource = (data) ->
      angular.extend this, data

    Resource.query = (returnType, successcb, errorcb) ->
      scb = successcb or angular.noop
      ecb = errorcb or angular.noop

      returnType = if returnType then returnType else "documents"      
      
      switch returnType
        when "documents", "blobs" then value = []
        else value = {}

      params = ( params || {} )


      request = 
        method: 'POST',
        url: url, 
        headers: 
          'Content-Type':'application/json+nxrequest'
        data: 
          params: params

      $http(request).then((response) ->                        
        data = response.data
        if data == "null"
          return null
        
        if data
          switch returnType
            when "documents","blobs" 
              angular.forEach data, (item) ->                
                value.push(new Resource(item));
            else
              angular.copy(data,value)  
        
        return value
      , (response) ->
        $q.reject(response.data.cause.cause.message)
      )            
      

    Resource
  NuxeoAutomation
])



.factory("NuxeoDirectory", ['NuxeoAutomation', (NuxeoAutomation) ->   
  NuxeoDirectory = (dirName) ->
    Directory  = {}
    
    Directory.query = ->
      NuxeoAutomation("Directory.Entries", {directoryName: dirName}).query("blobs")

    Directory
])
