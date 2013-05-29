describe 'Directory', ->

  $httpBackend = undefined
  continents = [
    {"id":"europe","label":"label.directories.continent.europe"},
    {"id":"africa","label":"label.directories.continent.africa"},
    {"id":"north-america","label":"label.directories.continent.north-america"},
    {"id":"south-america","label":"label.directories.continent.south-america"},
    {"id":"asia","label":"label.directories.continent.asia"},
    {"id":"oceania","label":"label.directories.continent.oceania"},
    {"id":"antarctica","label":"label.directories.continent.antarctica"}
  ]

  
  describe '#query a directory', ->

    beforeEach ->
      angular.module("test", ["services.nuxeo"]).constant "NUXEO_CONFIG", nuxeo_config =
        contextPath: "/nuxeo"
      module "test"

    beforeEach module('services.nuxeo')
    beforeEach inject(($httpBackend,NUXEO_CONFIG) ->      
      @httpBackend = $httpBackend
      
      $httpBackend.when('POST',[NUXEO_CONFIG.contextPath,'/site/automation/Directory.Entries'].join(""),
        '{"params":{"directoryName":"continent"}}').respond 200, continents

    )
  
    afterEach ->
      @httpBackend.verifyNoOutstandingExpectation()
      @httpBackend.verifyNoOutstandingRequest()


    it 'should be able to retrieve continents', inject((NuxeoDirectory, $httpBackend) ->
      resolved = false
      promise = NuxeoDirectory("continent").query()
      expect(promise).not.toBe undefined      
      conts = promise.then( (conts)->
        expect(conts.length).toBe 7
        expect(conts[0].id).toBe "europe"
        resolved = true
      )
      $httpBackend.flush()
      expect(resolved).toBe true
      
    )


    