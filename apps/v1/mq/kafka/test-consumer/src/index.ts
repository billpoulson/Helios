import dotenv from 'dotenv'
import { EachMessagePayload, Kafka, logLevel } from 'kafkajs'
dotenv.config()
console.log("starting consumer node")

const clientId = `${process.env.CLIENT_ID}-${+new Date()}`

if (process.env.NODE_ENV == "development") {
  const j = [
    clientId,
    process.env.BROKER,
    process.env.KAFKA_CLIENT_USER,
    process.env.GROUP_ID,
  ]
}
console.log("constructing kafka client")
const kafka = new Kafka({
  clientId,
  brokers: [process.env.BROKER],
  // brokers: [
  //   "my-kafka-controller-0.my-kafka-controller-headless.kafka-dev.svc.cluster.local:9092",
  //   "my-kafka-controller-1.my-kafka-controller-headless.kafka-dev.svc.cluster.local:9092",
  //   "my-kafka-controller-2.my-kafka-controller-headless.kafka-dev.svc.cluster.local:9092",
  // ],
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
  console.log("connected to broker")

  // Subscribing to a topic
  await consumer.subscribe({ topic: 'b', fromBeginning: true })
  console.log("subscribed to topic")

  // Running the consumer to listen for messages
  console.log("awaiting message")
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
