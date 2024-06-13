export const handler = (req: Request): Response => {
    const host = Deno.hostname() // Get the hostname of the current machine
    return new Response(`Hello, this is a deno edge function running on host: ${host}`, {
        headers: { 'content-type': 'text/plain' },
    })
}

