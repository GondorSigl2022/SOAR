export {}

var mongoClient = require("mongodb").MongoClient;
const express = require('express');
const app = express();
const port = 80;

//MongoDB
const url = "mongodb://db-manager:27017,db-node1:27017,db-node2:27017/cocktails/?replicaSet=rs0"
const dbName = 'cocktails';
let db : any = null;

//Connect to mongodb
mongoClient.connect(url, function(err : any, client : any) {
    console.log("Connected successfully to server");
    db = client.db(dbName);  
});

app.get('/api/cocktails/', async (req : Error, res : any) => {
    const cocktails =  await db.collection('cocktails').find().toArray();
    res.status(200).send(JSON.stringify(cocktails));
})

app.post('/api/cocktails/', (req : any, res : any) => {
    const name = req.body.name;
    const content = req.body.content;
    const id = req.body.id;

    const toAdd = {id, name, content};
    db.collection("cocktails").insertOne(toAdd, function(err : Error, res : any) {
        if (err) throw err;
        console.log("1 document inserted");
    });
    res.status(201).send();
})
  
app.listen(port, () => {
    console.log(`Listening on port :${port}` )
})