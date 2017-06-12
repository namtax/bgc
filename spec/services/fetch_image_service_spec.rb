describe FetchImageService do 
  subject { described_class.new(image_uid) }

  describe '.run' do
    let!(:image)      { File.open(image_path) }
    let(:image_path)  { "tmp/image_destination/XXXXYYYYYY.jpg" }
    
    context 'file type missing' do
      let(:image_uid) { 'XXXXYYYYYY' }
      let(:header) do
        ['Content-Disposition', "attachment; filename*=UTF-8''#{image_uid}.jpg"] 
      end

      it 'retrieves file via uid' do 
        expect(subject.run[:file].path).to eq(image.path)
      end 

      it 'returns valid header' do
        expect(subject.run[:header]).to eq(header)
      end
    end

    context 'file type is png' do 
      let(:image_uid)      { 'XXXXYYYYYY.png' }
      let(:png_image_path) { "tmp/image_destination/XXXXYYYYYY.png" }

      it 'returns a png image' do 
        expect(subject.run[:file].path).to eq(png_image_path)
      end
    end

    after do 
      FileUtils.rm_rf(Dir['tmp/image_destination/*png'])
    end
  end
end
