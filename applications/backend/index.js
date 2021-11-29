const express = require('express')
var cors = require('cors')
const app = express()

app.use(cors())
app.get('/:name', (req,res) => {
    const name = req.params.name
    console.log(name)
    res.status(200).send(`Welcome ${name}, this is the SOAR project by the Gondor group`)
})

app.listen(8080, () => {
  console.log("Serveur à l'écoute")
})
