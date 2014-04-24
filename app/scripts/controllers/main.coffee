'use strict';

app = angular.module 'coretrackerApp'

app.controller 'MainCtrl', ['$scope', '$modal', 'TasksModel', 'TasksService', ($scope, $modal, TasksModel, TasksService) ->
	@tasksData = TasksModel

	@period = 'daily'

	@periods = [
			label: 'Daily'
			value: 'daily'
		,
			label: 'Weekly'
			value: 'weekly'
		,
			label: 'Monthly'
			value: 'monthly'
	]

	TasksModel.getTasksFromTo 'daily'

	@showToday = =>
		@period = 'daily'
		TasksModel.getTasksFromTo 'daily'
		@

	@swapTo = (value) =>
		#
		param = 'daily'
		#
		switch value
			# 'daily' is default value, do not handle this case
			#when 'daily' then TasksModel.getTasksFromTo 'daily'
			when 'weekly' then param = 'weekly'
			when 'monthly' then param = 'monthly'
		#
		@period = param
		TasksModel.getTasksFromTo param
		#

	@decrementTaskOccuredCount = (task)->
		TasksService.decrementTaskCount task.id, '04-21-2014', (data)->
			task.occuredCount--

	@incrementTaskOccuredCount = (task)->
		TasksService.incrementTaskCount task.id, '04-21-2014', (data)->
			task.occuredCount++

	@editTask = (task)->
		TasksService.editTask task.id, (data)->
			$modal.open 
				templateUrl: 'views/task_edit.html'
				controller: 'TaskEditCtrl as taskEditCtrl'
			#
			console.log data

	@createTask = ->
		$modal.open
			templateUrl: 'views/task_create.html'
			controller: 'TaskCreateCtrl as taskCreateCtrl'

	# return controller
	return @
]

app.controller 'SummaryCtrl', ['$scope', 'TasksModel', ($scope, TasksModel)->
	$scope.tasks = TasksModel
	#
	@daily = new TaskSummary
	@weekly = new TaskSummary
	@monthly = new TaskSummary
	#
	@periods = [
			title: 'Daily'
			reference: @daily
		,
			title: 'Weekly'
			reference: @weekly
		,
			title: 'Monthly'
			reference: @monthly

	]
	# period specifc watch function for daily tasks updates
	dailyUpdate = (tasks)=>
		#
		periodUpdate tasks, @daily
	# period specifc watch function for weekly tasks updates
	weeklyUpdate = (tasks)=>
		periodUpdate tasks, @weekly
	# period specifc watch function for monthly tasks updates
	monthlyUpdate = (tasks)=>
		periodUpdate tasks, @monthly
	#
	periodUpdate = (tasks, period)->
		# skip initial digest
		return unless tasks# and tasks.businessTasks and tasks.personalTasks
		# get full list of tasks, we don't care about personal/business difference
		tasksList = (task.tasks for task in tasks).reduce (t, s)-> t.concat s
		# sum number of occurrencies for all tasks
		sum = if tasksList.length isnt 0 then (task.occuredCount for task in tasksList).reduce (t, s)-> t + s else 0
		#
		period.current = sum
		# sum number of required occurrencies for all tasks
		sum = if tasksList.length isnt 0 then (task.occurenciesNumber for task in tasksList).reduce (t, s)-> t + s else 0
		#
		period.total = sum
		#
		@
	#
	$scope.$watch (()->TasksModel.dailyTasks), dailyUpdate, true
	$scope.$watch (()->TasksModel.weeklyTasks), weeklyUpdate, true
	$scope.$watch (()->TasksModel.monthlyTasks), monthlyUpdate, true
	#
	@bootstrapProgressbarViewHelper = (taskSummary)->
		#
		percent = taskSummary.getProgressPercentage()
		#
		if percent >= 67 
			"progress-bar-success" 
		else if percent >= 34 
			"progress-bar-warning"
		else 
			"progress-bar-danger"
	#
	return @
]

app.controller 'TaskEditCtrl', ['$scope', '$modalInstance', ($scope, $modalInstance)->
	#
	@task = 
		category: 'My Tasks'
		title: 'Call 1 prospect'
		occurenciesNumber: 1
		comments: "Use my contacts list and call 1 person per day."
		interval: 2
	#
	@close = ->
		$modalInstance.close()
	#
	@submit = ->
		# action="/Tracker/Edit/editTaskForm" method="post"
		console.log 'task edit submit'
		@
	@delete = ->
		#/Tracker/Delete/26
		console.log 'delete task'
		@
	#
	return @
]

app.controller 'TaskCreateCtrl', ['$scope', '$modalInstance', ($scope, $modalInstance)->
	#
	@task = 
		category: ''
		title: ''
		occurenciesNumber: 1
		comments: ''
		interval: 2
	#
	@close = ->
		$modalInstance.close()
	#
	@submit = ->
		# action="/Tracker/AddTask" method="post"
		console.log 'task create submit'
		@
	#
	return @
]

INTEGER_REGEXP = /^\-?\d+$/
#
app.directive 'integer', () ->
  require: 'ngModel'
  link: (scope, elm, attrs, ctrl) ->
    ctrl.$parsers.unshift (viewValue) ->
    	if INTEGER_REGEXP.test viewValue 
	        # it is valid
	        ctrl.$setValidity 'integer', true
	        #
	        return viewValue
      	else
	        # it is invalid, return undefined (no model update)
	        ctrl.$setValidity 'integer', false
	        return undefined

class TaskSummary
	constructor: (current, total)->
		@current = if current then current else 0
		@total = if total then total else 0

	getProgressPercentage: ()->
		Math.floor @current * 100 / @total