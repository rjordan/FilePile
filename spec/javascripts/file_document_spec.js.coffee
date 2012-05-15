#= require jquery
#= require jquery.mockjax
#= require knockout-2.0.0
#= require file_document

describe 'FileDocument', ->
  $.mockjax
    url: '/files/1/tags'
    responseTime: 100
    responseText: '{}'

  describe 'when created from JSON', ->
    testData = { _id: 1, file_name: 'test.jpg', file_id: 2, file_size: 256, tags: ['tag1','tag2'] }
    doc = new FileDocument(testData)
    it 'should be createable', ->
      expect(doc).toNotBe(null)
    it 'should have a valid id', ->
      expect(doc.id).toEqual(1)
    it 'should have a valid name', ->
      expect(doc.file_name).toEqual('test.jpg')
    it 'should have a valid file_id', ->
      expect(doc.file_id).toEqual(2)
    it 'should have a valid file_size', ->
      expect(doc.file_size).toEqual(256)
    it 'should have a valid location', ->
      expect(doc.location).toEqual('/files/1')
    it 'should have a valid tags', ->
      #expect(doc.tags().length).toEqual(2)
      expect(doc.tags()).toEqual(['tag1', 'tag2'])

  it 'should accept new tags', ->
    testData = { _id: 1, file_name: 'test.jpg', file_id: 2, file_size: 256, tags: ['tag1','tag2'] }
    doc = new FileDocument(testData)
    expect(doc.tags()).toNotContain('tag3')
    doc.addTag 'tag3'
    expect(doc.tags()).toContain('tag3')

  it 'should ignore duplicate tags', ->
    testData = { _id: 1, file_name: 'test.jpg', file_id: 2, file_size: 256, tags: ['tag1','tag2'] }
    doc = new FileDocument(testData)
    expect(doc.tags().length).toEqual(2)
    doc.addTag 'tag2'
    expect(doc.tags().length).toEqual(2)

  it 'should be able to remove existing tags', ->
    testData = { _id: 1, file_name: 'test.jpg', file_id: 2, file_size: 256, tags: ['tag1','tag2'] }
    doc = new FileDocument(testData)
    expect(doc.tags()).toContain('tag2')
    doc.removeTag 'tag2'
    expect(doc.tags()).toNotContain('tag2')
    


