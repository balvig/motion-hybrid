describe 'MotionHybrid::BasicRoutes' do

  tests MotionHybrid::Screen

  after do
    @screen = nil
  end

  def controller
    MotionHybrid::Screen.root_url = NSURL.fileURLWithPath(NSBundle.mainBundle.resourcePath + '/web').to_s
    @screen ||= MotionHybrid::Screen.new(path: '/index.html', nav_bar: true)
    @screen.navigationController
  end

  it "pushes a basic GET link" do
    wait 0.6 do
      view_should_have_content('Page 2')
      click_link('Page 2')
      wait 0.6 do
        @screen.presentedViewController.nil?.should == true
        @screen.navigationController.viewControllers.count.should == 2
        view_should_have_content('This is page 2')
      end
    end
  end

  it "loads #self link inline" do
    @screen.path = '/index_2.html'

    wait 0.6 do
      click_link 'Page with alert'
      wait 0.6 do
        @screen.navigationController.viewControllers.count.should == 1
        view_should_have_content('Congratulations!')
      end
    end
  end

  it "pops up #modal link" do
    wait 0.6 do
      click_link 'Modal'
      wait 0.6 do
        @screen.navigationController.viewControllers.count.should == 1
        @screen.presentedViewController.should.not.be.nil
        view_should_have_content 'This will close the modal'
      end
    end
  end

  it "closes modal when going to url of presenter" do
    wait 0.6 do
      click_link 'Modal'
      wait 0.6 do
        @screen.navigationController.viewControllers.count.should == 1
        @screen.presentedViewController.should.not.be.nil
        click_link 'This will close the modal'
        wait 0.6 do
          @screen.presentedViewController.should.be.nil
        end
      end
    end
  end

  #it "#hide_tab_bar link" do
    #stub_request(:get, "http://github.com/").to_return(body: '<a href="/page_2#hide_tab_bar" id="link">To page 2</a>')
    #stub_request(:get, "http://github.com/page_2#hide_tab_bar").to_return(body: 'This is page 2')

    #wait 0.6 do
      #@screen.evaluate('document.getElementById("link").click();')
      #wait 0.6 do
        #@screen.navigationController.viewControllers.count.should == 2
        #@screen.navigationController.viewControllers.last.html.include?('This is page 2').should == true
      #end
    #end
  #end
  #
  #
  def current_view
    top_view = @screen.navigationController.topViewController
    top_view.presentedViewController.nil? ? top_view : top_view.presentedViewController.viewControllers.last
  end

  def click_link(text)
    current_view.evaluate("$('a:contains(\"#{text}\")').get(0).click();")
  end

  def view_should_have_content(text)
    current_view.html.include?(text).should.be.true
  end
end
