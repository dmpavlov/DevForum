var app = angular.module('devForumApp', []);

app.controller('companiesCtrl', function () {
    this.title = "Companies";

    this.isVisible = function () {
        return !this.list.length;
    };

    this.addCompany = function () {
        this.list.push(
            {
                id: this.list.length,
                legalName: this.legalName,
                state: this.state,
                city: this.city
            });

        this.legalName = '';
        this.state = '';
        this.city = '';
    };

    this.list = [
        {
            "id": 0,
            "legalName": "AAAA, Rowe and Rolfson",
            "state": "Alabama",
            "city": "Saigeborough"
        },
        {
            "id": 1,
            "legalName": "Treutel, Macejkovic and Jones",
            "state": "Texas",
            "city": "Robelshire"
        },
        {
            "id": 2,
            "legalName": "Russel, Herzog and Skiles",
            "state": "Pennsylvania",
            "city": "North Kristophershire"
        },
        {
            "id": 3,
            "legalName": "Lubowitz and Daughters",
            "state": "New Hampshire",
            "city": "Linnietown"
        },
        {
            "id": 4,
            "legalName": "Pouros Inc",
            "state": "North Carolina",
            "city": "West Sylvia"
        },
        {
            "id": 5,
            "legalName": "Hegmann Inc",
            "state": "Hawaii",
            "city": "Naderchester"
        }];
});

app.controller('tabsCtrl', function () {
    this.activeTab = 1;

    this.isSet = function (tabNumber) {
        return this.activeTab === tabNumber;
    };

    this.setTab = function (tabNumber) {
        this.activeTab = tabNumber;
    };
});

app.controller('presentersCtrl', ['$http', function ($http) {
    this.title = "Coming soon...";

    this.list = [];
    var store = this;

    $http.get('http://localhost:3000/presenters')
        .success(function (data) {
            store.list = data;
        });
}]);

//app.directive('companyTitle', function () {
//    return {
//        restrict: 'E',
//        template: '<div class="page-header">' +
//        '<h1>{{companies.title}}</small></h1>' +
//        '</div>'
//    }
//});

app.directive('companyTitle', function () {
    return {
        restrict: 'E',
        templateUrl: 'app/company-title.html'
    }
});

app.directive('companies', function() {
   return {
       restrict: 'E',
       templateUrl: 'app/companies.html'
   }
});

app.directive('addCompanyForm', function() {
   return {
       restrict: 'E',
       templateUrl: 'app/add-company-form.html'
   }
});



