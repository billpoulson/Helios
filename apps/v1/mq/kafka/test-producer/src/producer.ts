import { Kafka, Partitioners, logLevel } from 'kafkajs'

// Environment variable KAFKAJS_NO_PARTITIONER_WARNING to silence partitioner warning
process.env.KAFKAJS_NO_PARTITIONER_WARNING = '1';
const kafka = new Kafka({
  clientId: 'my-producer',
  brokers: ['my-kafka.kafka-dev.svc.cluster.local:9092'],
  logLevel: logLevel.WARN
});

const producer = kafka.producer({
  createPartitioner: Partitioners.LegacyPartitioner
});

const run = async () => {
  try {
    await producer.connect();
    for (let i = 0; i < 10; i++) {
      await producer.send({
        topic: 'test-topic',
        messages: [
          { value: `Hello KafkaJS user! ${i}` },
        ],
      });
    }
  } catch (error) {
    console.error('An error occurred:', error);
  } finally {
    await producer.disconnect();
  }
};

run().catch(error => {
  console.error('Failed to execute run:', error);
});
