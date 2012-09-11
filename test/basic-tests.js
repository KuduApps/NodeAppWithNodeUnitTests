

var uuid = require('node-uuid');

var path = require('path');


var util = require('util');
var fs = require('fs');

var testCase = require('nodeunit').testCase;

var now = new Date().toString();


var testPrefix = 'basic-tests';

module.exports = testCase(
  {
    setUp: function(callback) {
      
            callback();
    },

    tearDown: function(callback) {
             callback();
    },

    passing: function( test) {
                test.equal(true, false);
                test.done();
    }

});