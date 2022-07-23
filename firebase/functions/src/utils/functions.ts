// eslint-disable-next-line import/no-unresolved
import { config } from 'dotenv'
import { getFirestore } from 'firebase-admin/firestore'
import * as fs from 'fs'
import { resolve } from 'path'

config()

const insertMultipleDoc = <T>(data: Array<T>) => {
  const db = getFirestore()
  const batch = db.batch()

  data.forEach((single) => {
    const userDoc = db.collection('users').doc()
    batch.set(userDoc, single)
  })

  batch.commit()
}

const getAbsolutePath = (path: string) => resolve(__dirname, path)

const createDirectory = (path: string) =>
  fs.promises.mkdir(path, { recursive: true }).catch(console.error)

const env = (key: string) => {
  const environmentValue = process.env[key]

  if (environmentValue === undefined) {
    throw new Error(`${key} 값을 찾을 수가 없습니다.`)
  }

  return environmentValue
}

export { insertMultipleDoc, getAbsolutePath, createDirectory, env }
