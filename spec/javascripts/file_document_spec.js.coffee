//= require file_document

describe 'FileDocument', ->
  testData = { _id: 1, file_name: 'test.jpg', file_id: 2, file_size: 256, tags: ['tag1','tag2'] }

  describe 'A new FileDocument', ->
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
      doc.location.should.equal('/files/2')
    it 'should have a valid tags', ->
      doc.tags().length.should.equal(2)
      doc.tags().should.include('tag1')
      doc.tags().should.include('tag2')

