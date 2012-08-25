# encoding: utf-8
require 'spec_helper'

TEST_VECTORS = [
  ['password','salt',1,20,'0c60c80f961f0e71f3a9b524af6012062fe037a6'],
  ['password','salt',2,20,'ea6c014dc72d6f8ccd1ed92ace1d41f0d8de8957'],
  ['password','salt',4096,20,'4b007901b765489abead49d926f721d065a429c1'],
#  ['password','salt',16777216,20,'eefe3d61cd4da4e4e9945b3d6ba2158c2634e984'],
  ['passwordPASSWORDpassword','saltSALTsaltSALTsaltSALTsaltSALTsalt',4096,    25,'3d2eec4fe41c849b80c8d83662c0e44a8b291a964cf2f07038'],
  ["pass\0word","sa\0lt",4096,16,'56fa6aa75548099dcc37d7f03425e0c3']
]

describe Dpass do
  describe "Verify RFC 6070 test vectors" do
    i = 0
    TEST_VECTORS.each do |data|
      i += 1
      it "matches test vector #{i}" do
        Dpass.derive_raw_hex(data[0],data[1],data[2],data[3]).should eq(data[4])
      end
    end
  end

  describe "Reading salt file" do
    it "should raise error if file does not exist" do
      File.stub!(:exists?).and_return(false)
      expect{Dpass.read_salt}.to raise_error(StandardError)
    end
    it "should have correct length" do
      # This only works with actual salt file
      #  but can't figure out how to stub this
      Dpass.read_salt.length.should eq(32)
    end
    it "should contain only hexidecimal characters" do
      # This only works with actual salt file
      #  but can't figure out how to stub this
      Dpass.read_salt.gsub(/[0-9a-f]/,'').length.should eq(0)
    end
  end

  describe "Generating new salt file" do
    describe "generate a random salt string" do
      it "should be non-nil" do
        Dpass.generate_salt.length.should eq(32)
      end
      it "should contain only hexidecimal characters" do
        Dpass.generate_salt.gsub(/[0-9a-f]/,'').length.should eq(0)
      end
    end
    it "should not change an existing salt file" do
      File.stub!(:exists?).and_return(true)
      expect{Dpass.new_salt}.to raise_error(StandardError)
    end
  end
end
