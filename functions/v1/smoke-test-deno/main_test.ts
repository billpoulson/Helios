import { assertEquals } from "https://deno.land/std@0.103.0/testing/asserts.ts"
import { handler } from "./src/handler.ts"
// Test
Deno.env.set('PORT', '8080')

// Save the original Deno.hostname() function
const originalDenoHostname = Deno.hostname

// Mock implementation for Deno.hostname()
const mockHostname = () => "test-host"

// Replace the Deno.hostname() with the mock
Deno.hostname = mockHostname

Deno.test("server responds with correct message", async () => {
  const request = new Request('http://localhost:8080')


  const response = await handler(request)
  const text = await response.text()
  assertEquals(response.status, 200)
  assertEquals(text, 'Hello, this is a deno edge function running on host: test-host')
  assertEquals(response.headers.get('content-type'), 'text/plain')
})
