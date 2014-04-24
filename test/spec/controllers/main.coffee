beforeEach module 'ui.bootstrap'
beforeEach module 'coretracker.factories'
beforeEach module 'coretracker.services'
beforeEach module 'coretrackerApp'

describe 'Controller: MainCtrl', ->
  # load the controller's module

  MainCtrl = TasksModel = $modal = TasksService = {}

  # # # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope, _$modal_, _TasksModel_, _TasksService_) ->
    scope = $rootScope.$new()
    #
    MainCtrl = $controller 'MainCtrl', 
      $scope: scope
    #
    TasksModel = _TasksModel_
    $modal = _$modal_
    TasksService = _TasksService_

  it 'should provide showToday method', ->
      (expect MainCtrl.showToday).toBeDefined()

  it 'should change period and request \'daily\' tasks on showToday call', ->
    MainCtrl.period = 'dummy period'
    #
    spyOn TasksModel, 'getTasksFromTo'
    #
    MainCtrl.showToday();
    #
    expect(MainCtrl.period).not.toBe 'dummy period'
    expect(TasksModel.getTasksFromTo).toHaveBeenCalled()
  
  it 'should provide three time periods', ->
      (expect MainCtrl.periods).toBeDefined()
      (expect MainCtrl.periods.length).toBe 3

  it 'should provide time period with label and value', ->
      (expect MainCtrl.periods[0].label).toBeDefined()
      (expect MainCtrl.periods[0].value).toBeDefined()
  
  it 'should provide swapTo method', ->
    (expect MainCtrl.swapTo).toBeDefined()
  
  it 'should change active period after swapTo call', ->
    MainCtrl.period = 'dummy period'
    MainCtrl.swapTo MainCtrl.periods[0].value
    (expect MainCtrl.period).toEqual MainCtrl.periods[0].value
  
  it 'should provide createTask method', ->
    (expect MainCtrl.createTask).toBeDefined()
  
  it 'should open modal popup on createTask call', ->
    spyOn $modal, 'open'
    MainCtrl.createTask id: ''
    (expect $modal.open).toHaveBeenCalled()

  it 'should have TasksModel reference as tasksData', ->
    (expect MainCtrl.tasksData).toEqual TasksModel
  
  it 'should provide editTask method', ->
    (expect MainCtrl.editTask).toBeDefined()
  
  it 'should call editTask method on TasksService', ->
    spyOn TasksService, 'editTask'
    MainCtrl.editTask id: ''
    (expect TasksService.editTask).toHaveBeenCalled()
  
  it 'should provide decrementTaskOccuredCount method', ->
    (expect MainCtrl.decrementTaskOccuredCount).toBeDefined()

  it 'should create modal window on decrementTaskOccuredCount', ->
    spyOn TasksService, 'decrementTaskCount'
    MainCtrl.decrementTaskOccuredCount id: ''
    expect(TasksService.decrementTaskCount).toHaveBeenCalled()
  
  it 'should provide incrementTaskOccuredCount method', ->
    (expect MainCtrl.incrementTaskOccuredCount).toBeDefined()

  it 'should create modal window on incrementTaskOccuredCount', ->
    spyOn TasksService, 'incrementTaskCount'
    MainCtrl.incrementTaskOccuredCount id: ''
    expect(TasksService.incrementTaskCount).toHaveBeenCalled()
