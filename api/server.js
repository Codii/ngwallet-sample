var express = require('express')
	, app = express()
	, sqlite3 = require('sqlite3')
	, connect = require('express-myconnection')
	, dbConfig = {}
	;