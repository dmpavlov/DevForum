module.exports = function () {
    var faker = require("faker");
    var _ = require("lodash");

    return {
        presenters: _.times(30, function (n) {
            return {
                id: n,
                name: faker.name.findName(),
                email: faker.internet.email(),
                avatar: faker.internet.avatar()
            }
        }),
        companies: _.times(10, function (n) {
            return {
                id: n,
                legalName: faker.company.companyName(),
                state: faker.address.state(),
                city: faker.address.city()
            }
        })
    }
}