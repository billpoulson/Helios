import dotenv from 'dotenv'
dotenv.config()

import { EachMessagePayload, Kafka, logLevel } from 'kafkajs'

const brokers = [
  'exhelion.local:9092'
]

const kafka = new Kafka({
  clientId: process.env.CLIENT_ID,
  brokers: [process.env.BROKER],
  ssl: false,
  logLevel: process.env.LOG_LEVEL as unknown as logLevel,
  sasl: {
    mechanism: 'scram-sha-256', // Choose your desired scram mechanism
    username: process.env.KAFKA_CLIENT_USER,
    password: process.env.KAFKA_CLIENT_PASSWORD,
  },
})
const consumer = kafka.consumer({
  groupId: process.env.GROUP_ID,
  allowAutoTopicCreation: true
})

const run = async () => {
  // Connecting the consumer
  await consumer.connect()

  // Subscribing to a topic
  await consumer.subscribe({ topic: 'aaa1', fromBeginning: true })

  // Running the consumer to listen for messages
  await consumer.run({
    eachMessage: async ({ topic, partition, message }: EachMessagePayload) => {
      console.log({
        partition,
        offset: message.offset,
        value: message.value?.toString(),
      })
    },
  })
}

// Handling errors
run().catch(console.error)

// Gracefully shutdown on exit
const shutdown = async () => {
  await consumer.disconnect()
  process.exit(0)
}

process.on('SIGINT', shutdown)
process.on('SIGTERM', shutdown)
