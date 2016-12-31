angular.module('FahsaiRich168')
	.controller('SearchUserCrtl', ['$scope', '$http', function($scope, $http){
	  var host = "https://project-freelance1-031160-t-icaria555.c9users.io";
	  $scope.users = [];
	  
	  
	  $scope.sync_users = function () {
			$http.get(host + "/users")
			.then(function (res) {
				$scope.users = res.data;
				console.log(res.data)
			});
		};
	  $scope.sync_users()
	  
	}]);
