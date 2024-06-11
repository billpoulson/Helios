
import express from 'express'
import os from 'os' // Import the os module to get the hostname

const app = express()
const port = process.env.PORT || 8080  // Retrieve port from environment variable, default to 8080 if not set
const hostname = os.hostname()  // Get the hostname of the current machine

app.get('/*', (req, res) => {
    res.send(`Hello, this is an edge function running on host: ${hostname}`)
})

app.listen(port, () => {
    // console.log(`Server is running at http://localhost:${port}`)
    console.log(`Running on host: ${hostname}:${port}`)
})