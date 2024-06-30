
import { serve } from 'https://deno.land/std@0.114.0/http/server.ts'
import { load } from "https://deno.land/std@0.224.0/dotenv/mod.ts"

import { handler } from "./handler.ts"

const configData = await load({
  export: true,
  allowEmptyValues: true,
  envPath: "",
})

const port = Deno.env.get('PORT') || 8080 // Retrieve port from environment variable, default to 8080 if not set
const host = Deno.hostname() // Get the hostname of the current machine

console.log(`Running on host: ${host}:${port}`)
serve(handler, { addr: `:${port}` }) // Provide host address with port
