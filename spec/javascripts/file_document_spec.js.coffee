//= require jquery
//= require jquery.mockjax
//= require knockout-2.0.0

//= require file_document

describe 'FileDocument', ->
  $.mockjax
    url: '/files/1/tags'
    responseTime: 100
    responseText: '{}'

  describe 'when created from JSON', ->
    testData = { _id: 1, file_name: 'test.jpg', file_id: 2, file_size: 256, tags: ['tag1','tag2'] }
    doc = new FileDocument(testData)
    it 'should be createable', ->
      doc.should.exist
    it 'should have a valid id', ->
      doc.id.should.equal(1)
    it 'should have a valid name', ->
      doc.file_name.should.equal('test.jpg')
    it 'should have a valid file_id', ->
      doc.file_id.should.equal(2)
    it 'should have a valid file_size', ->
      doc.file_size.should.equal(256)
    it 'should have a valid location', ->
      doc.location.should.equal('/files/1')
    it 'should have a valid tags', ->
      #doc.tags().length.should.equal(2)
      doc.tags().should.equal(['tag1', 'tag2'])

  it 'should accept new tags', ->
    testData = { _id: 1, file_name: 'test.jpg', file_id: 2, file_size: 256, tags: ['tag1','tag2'] }
    doc = new FileDocument(testData)
    doc.tags().should.not.include('tag3')
    doc.addTag 'tag3'
    doc.tags().should.include('tag3')

  it 'should ignore duplicate tags', ->
    testData = { _id: 1, file_name: 'test.jpg', file_id: 2, file_size: 256, tags: ['tag1','tag2'] }
    doc = new FileDocument(testData)
    doc.tags().length.should.equal(2)
    doc.addTag 'tag2'
    doc.tags().length.should.equal(2)

  it 'should be able to remove existing tags', ->
    testData = { _id: 1, file_name: 'test.jpg', file_id: 2, file_size: 256, tags: ['tag1','tag2'] }
    doc = new FileDocument(testData)
    doc.tags().should.include('tag2')
    doc.removeTag 'tag2'
    doc.tags().should.not.include('tag2')
    


