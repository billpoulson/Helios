// import { Kafka, logLevel } from 'kafkajs'

// // Kafka broker addresses
// const brokers = [
//   'my-kafka-controller-0.my-kafka-controller-headless.kafka-dev.svc.cluster.local:9092',
//   'my-kafka-controller-1.my-kafka-controller-headless.kafka-dev.svc.cluster.local:9092',
//   'my-kafka-controller-2.my-kafka-controller-headless.kafka-dev.svc.cluster.local:9092',
// ]

// // Initialize Kafka instance
// const kafka = new Kafka({
//   clientId: 'my-kafka-consumer',
//   brokers,
//   logLevel: logLevel.DEBUG,
//   sasl: {
//     mechanism: 'scram-sha-256', // Choose your desired scram mechanism
//     username: 'user1',
//     password: 'boMGjEa3iL', // It's safer to use environment variables
//   },
//   ssl: false,
// })

// // Initialize Kafka consumer
// const consumer = kafka.consumer({ groupId: 'test-group' })

// const run = async () => {
//   try {
//     // Connect the consumer
//     await consumer.connect()
//     console.log('Consumer connected')

//     // Subscribe to the topic 'test-topic'
//     await consumer.subscribe({ topic: 'test-topic', fromBeginning: false })
//     console.log('Consumer subscribed to topic')

//     // Run the consumer to process messages
//     await consumer.run({
//       eachMessage: async ({ topic, partition, message }) => {
//         const prefix = `${topic}[${partition} | ${message.offset}] / ${message.timestamp}`
//         const key = message.key?.toString()
//         const value = message.value?.toString()
//         console.log(`- ${prefix} ${key}#${value}`)
//       },
//     })  

//     console.log('Consumer is running')
//   } catch (error) {
//     console.error('Error in consumer setup or run:', error)
//   }
// }

// run().catch(error => console.error('Error in run function:', error))







import { EachMessagePayload, Kafka } from 'kafkajs'
// brokers: [],

const brokers = [
  'my-kafka.kafka-dev.svc.cluster.local:9092'
  // 'localhost:9092',
  // 'my-kafka-controller-headless.kafka-dev.svc.cluster.local:9092',
  // 'my-kafka-controller-0.my-kafka-controller-headless.kafka-dev.svc.cluster.local:9092',
  // 'my-kafka-controller-1.my-kafka-controller-headless.kafka-dev.svc.cluster.local:9092',
  // 'my-kafka-controller-2.my-kafka-controller-headless.kafka-dev.svc.cluster.local:9092',
]
const kafka = new Kafka({
  clientId: 'my-app',
  brokers,
  ssl: false,
  // logLevel: logLevel.DEBUG,

  sasl: {
    mechanism: 'scram-sha-256', // Choose your desired scram mechanism
    username: 'user1',
    password: 'boMGjEa3iL', // It's safer to use environment variables
  },
})
const consumer = kafka.consumer({
  groupId: 'test-group',
  allowAutoTopicCreation: true
})

const run = async () => {
  // Connecting the consumer
  await consumer.connect()

  // Subscribing to a topic
  await consumer.subscribe({ topic: 'test-topic', fromBeginning: true })

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
