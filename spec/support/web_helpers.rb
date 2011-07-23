def row_containing(text)
  [:xpath, "//li[contains(.,'#{text}')] | //tr[contains(.,'#{text}')]"]
end

def refresh_page
  visit current_path
end

def i_should_see(content,  opts={})
  if opts[:before]
    page.body.index(content.to_s).should < page.body.index(opts[:before].to_s)
  else
    page.should have_content content
  end
end
