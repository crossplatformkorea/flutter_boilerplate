import { env } from '../src/utils/functions'

describe('Utils', () => {
  describe('env', () => {
    test('Environment variables without keys cause an error.', () => {
      expect(() => env('kkk')).toThrow()
    })
    test('The value of the SHOULD_USE_EMULATOR key must be Boolean.', () => {
      expect(env('SHOULD_USE_EMULATOR')).toBeTruthy()
    })
  })
})
