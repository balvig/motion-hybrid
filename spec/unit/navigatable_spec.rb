describe MotionHybrid::Navigatable do
  it "should parse path correctly for localhost" do
    MotionHybrid::Screen.path_for('http://localhost:3000/chats').should == '/chats'
  end
end
