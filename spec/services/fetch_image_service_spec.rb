describe FetchImageService do 
  subject { described_class.new(image_uid) }

  describe '.run' do
    let(:image_uid)   { 'XXXXYYYYYY' }
    let(:image_path)  { "tmp/image_destination/#{image_uid}.jpg" }
    let!(:image)      { File.new(image_path, 'w+') }
    let(:image_store) { Dir['tmp/image_destination/*'] }
    let(:header)      { ['Content-Disposition', "attachment; filename*=UTF-8''#{image_uid}.jpg"] }

    it 'retrieves file via uid' do 
      expect(subject.run[:file].path).to eq(image.path)
    end 

    it 'returns valid header' do
      expect(subject.run[:header]).to eq(header)
    end

    after do 
      FileUtils.rm_rf(image_store)
    end
  end
end
