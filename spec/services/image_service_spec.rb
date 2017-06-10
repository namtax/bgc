describe ImageService do 
  subject { described_class.new(file) }

  describe '.run' do
    let(:file) do 
      { 
        'filename' => 'original.jpg',
        'type' => 'image/jpg',
        'name' => 'image_file',
        'tempfile' => tempfile
      }
    end

    let(:tempfile)    { double(path: image_path) }
    let(:image_path)  { 'tmp/image_source/test.jpg' }
    let(:image_store) { Dir['tmp/image_destination/*'] }

    before do 
      File.new(image_path, 'w+')
    end

    it 'stores file with unique identifier' do 
      image_uid = subject.run
      expect(image_store.first).to eq("tmp/image_destination/#{image_uid}.jpg")
    end 

    after do 
      FileUtils.rm_rf(image_store)
    end
  end
end
