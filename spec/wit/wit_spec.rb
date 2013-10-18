require 'wit/wit'

describe Wit do

  describe ".message" do

    it "returns the expected output" do
      res = Wit.message('deploy master foo to bar')
      expect( res ).to be_a Wit::Response
      expect( res.msg_body ).to eq 'deploy master foo to bar'
      expect( res.intent ).to eq 'deploy'
      expect( res.entities[:branch] ).to be_a Wit::Entity
      expect( res.entities[:branch].value ).to eq 'master'
    end

  end

end
