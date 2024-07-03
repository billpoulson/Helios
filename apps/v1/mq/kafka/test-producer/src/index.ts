


import { Kafka, Partitioners, logLevel } from 'kafkajs'

// // Kafka broker addresses
// const brokers = [
//   'my-kafka-controller-0.my-kafka-controller-headless.kafka-dev.svc.cluster.local:9092',
//   'my-kafka-controller-1.my-kafka-controller-headless.kafka-dev.svc.cluster.local:9092',
//   'my-kafka-controller-2.my-kafka-controller-headless.kafka-dev.svc.cluster.local:9092',
// ]

// // Initialize Kafka instance
// const kafka = new Kafka({
//   clientId: 'my-producer',
//   brokers,
//   logLevel: logLevel.DEBUG,
//   // sasl: {
//   //   mechanism: 'scram-sha-256',
//   //   username: 'user1',
//   //   password: 'boMGjEa3iL',
//   // },
// })

// // Initialize Kafka producer
// // const producer = kafka.producer()
// const producer = kafka.producer({
//   createPartitioner: Partitioners.LegacyPartitioner
// })
// const run = async () => {
//   // Connect the producer
//   await producer.connect()
//   console.log('Producer connected')

//   // Send a message to the topic 'test-topic'
//   await producer.send({
//     topic: 'simple-topic',
//     messages: [
//       { value: 'Hello KafkaJS user!' },
//     ],
//   })

//   console.log('Message sent successfully')
// }

// // Execute the run function
// run().catch(e => console.error(`[kafka-producer] ${e.message}`, e)).finally(() => producer.disconnect());


// Environment variable KAFKAJS_NO_PARTITIONER_WARNING to silence partitioner warning
process.env.KAFKAJS_NO_PARTITIONER_WARNING = '1'
const kafka = new Kafka({
  clientId: 'my-producer',
  brokers: ['my-kafka.kafka-dev.svc.cluster.local:9092'],
  logLevel: logLevel.DEBUG,
  sasl: {
    mechanism: 'scram-sha-256',
    username: 'user1',
    password: 'boMGjEa3iL',
  },
  ssl: false
})

const producer = kafka.producer({
  createPartitioner: Partitioners.LegacyPartitioner,
  allowAutoTopicCreation: true,
})

const run = async () => {
  try {
    await producer.connect()
    let i = 0
    while (true) {
      await new Promise<void>((resolve, reject) => setTimeout(() => resolve(), 1000))
      await producer.send({
        topic: 'test-topic',
        messages: [
          { value: `Hello KafkaJS user! ${i}` },
        ],
      })
    }
  } catch (error) {
    console.error('An error occurred:', error)
  } finally {
    await producer.disconnect()
  }
}

run().catch(error => {
  console.error('Failed to execute run:', error)
})
