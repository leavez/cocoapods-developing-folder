require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::Folder do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ folder }).should.be.instance_of Command::Folder
      end
    end
  end
end

