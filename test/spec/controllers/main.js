'use strict';

describe('Controller: MainCtrl', function () {

  // load the controller's module
  beforeEach(module('angularBlogApp'));

  var MainCtrl,
    scope, httpBackend, params, querySpy;


  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    
    querySpy = jasmine.createSpy("query")

    var NuxeoDirectory = jasmine.createSpy("NuxeoDirectory").andCallFake(function() {
      var Directory = {}
      Directory.query = querySpy
      return Directory
    });
    
    params = {
      $scope: scope,
      NuxeoDirectory: NuxeoDirectory
    }

    MainCtrl = $controller('MainCtrl', params);

    
  }));


  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.awesomeThings.length).toBe(3);    
  });

  it('should call the NuxeoDirectory service', function() {
    expect(params.NuxeoDirectory).toHaveBeenCalledWith("continent")
    expect(querySpy).toHaveBeenCalled()
  });
});
