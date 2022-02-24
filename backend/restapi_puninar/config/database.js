import pg from "pg";

const CreatePool = pg.Pool;

var types = pg.types;
types.setTypeParser(1114, function(stringValue) {
return stringValue;
});

const pool = new CreatePool({
    user: "postgres",
    host: "localhost",
    database: "test_puninar",
    password: "root",
    port: 5432
})



export default pool;
