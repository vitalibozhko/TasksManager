'use strict'

sers = angular.module 'coretracker.services', []

sers.service 'TasksService', ['$http', '$cookies', '$timeout', ($http, $cookies, $timeout)->
	#
	apiBase = 'http://api-dev.fasttribe.com/api/proAlliance/'
	portalBase = 'http://www.proalliance.biz'
	userId = '{2783496A-1833-4CD8-879E-37FE9637E80E}'
	#
	$cookies.UserID = userId;
	#
	@incrementTaskCount = (taskId, date, callback)->
		params = 
			id: taskId
			userId: userId
			date: date
			responseType: 'json'

		httpParams = 
			params: params

		$timeout (-> callback 'sample data'), Math.random() * 1000

		#($http.get apiBase + 'Activities/Add', httpParams)
		#	.success (data, status, headers, config)->
		#		callback data
		#	.error (data, status, headers, config)->
		#		console.log "Activities add error ${data} ${status}"
	#
	@decrementTaskCount = (taskId, date, callback)->
		params =
			id: taskId
			userId: userId
			date: date
			responseType: 'json'

		httpParams = 
			params: params

		$timeout (-> callback 'sample data'), Math.random() * 1000

		#($http.get apiBase + 'Activities/Subtract', httpParams)
		#	.success (data, status, headers, config)->
		#		callback data
		#	.error (data, status, headers, config)->
		#		console.log "Activities subtract error #{data} #{status}"
	#
	@editTask = (taskId, callback)->
		#
		$timeout (-> callback 'sample data'), Math.random() * 1000
		#
#		($http.get portalBase + "/Tracker/Edit/#{taskId}")
#			.success (data, status, headers, config)->
#				callback data
#			.error (data, status, headers, config)->
#				console.log "Edit task error #{data} #{status}"
	# return this
	@
]
