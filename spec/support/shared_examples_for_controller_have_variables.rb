RSpec.shared_examples 'controller have variables' do |varibles|
  before do
    subject
  end

  varibles.each do |variable, class_name|
    it "should have @#{variable} variable" do
      expect(controller.instance_variable_get("@#{variable}")).to be
    end
    next unless class_name
    it "@#{variable} should be instance of #{class_name}" do
      expect(controller.instance_variable_get("@#{variable}")).to be_a(class_name)
    end
  end
end
