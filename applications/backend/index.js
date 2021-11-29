const express = require('express')
const app = express()

app.get('/:name', (req,res) => {
    const name = req.params.name
    res.status(200).send(`Welcome ${name}, this is the SOAR project by the Gondor group`)
})

app.listen(8080, () => {
  console.log("Serveur à l'écoute")
})
