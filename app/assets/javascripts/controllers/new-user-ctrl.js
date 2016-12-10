angular.module('FahsaiRich168')
	.controller('NewUserCtrl', ['$scope', '$http', function($scope, $http){
		var host = "https://project-freelance1-031160-t-icaria555.c9users.io";
		$scope.provinces = [];
		$scope.amphurs = [{name: "กรุณาเลือกจังหวัดก่อน"}];
		$scope.districts = [{name: "กรุณาเลือกอำเภอก่อน"}];
		$scope.zipcodes = [{code: "กรุณาเลือกตำบลก่อน"}];

		$scope.sync_provinces = function () {
			$http.get(host + "/provinces")
			.then(function (res) {
				$scope.provinces = res.data;
			});
		};
		$scope.sync_provinces();

		$scope.sync_amphurs = function (province_id) {
			$http.get(host + "/provinces/" + province_id + "/amphurs")
			.then(function (res) {
				$scope.amphur_id = "0";
				$scope.district_id = "0";
				$scope.zipcode_id = "0";
				$scope.amphurs = res.data;
			})
			.catch(function (res) {
				$scope.amphurs = [{name: 'กรุณาเลือกจังหวัดก่อน'}];
			});
		};

		$scope.sync_districts = function (amphur_id) {
			$http.get(host + "/amphurs/" + amphur_id + "/districts")
			.then(function (res) {
				$scope.district_id = "0";
				$scope.zipcode_id = "0";
				$scope.districts = res.data;
			})
			.catch(function (res) {
				$scope.districts = [{name: "กรุณาเลือกอำเภอก่อน"}];
			});
		};

		$scope.sync_zipcodes = function (district_id) {
			$http.get(host + "/districts/" + district_id + "/zipcodes")
			.then(function (res) {
				$scope.zipcode_id = "0";
				$scope.zipcodes = res.data;
			})
			.catch(function (res) {
				$scope.zipcodes = [{code: "กรุณาเลือกตำบลก่อน"}];
			});
		};

	}]);
