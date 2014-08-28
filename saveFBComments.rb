# require 'test_helper'

class CommentTest < Test::Unit::TestCase
  context "Comment" do
    should "get comments from Facebook" do
      VCR.use_cassette('poland_com') do
        comments = FbUtils::Comment.get("http://poland.com")
        assert_kind_of Array, comments
        assert_equal "hey there!", comments[0].message
        assert_equal "10150114889322623_19119228", comments[0].id
        assert_equal "1039207562", comments[0].from_id
        assert_equal "Lukasz Kr", comments[0].from_name
      end
    end

    should "get comments from Facebook and save them in txt, csv file" do
      VCR.use_cassette('poland_com') do
        comments = FbUtils::Comment.save("http://poland.com", "poland_com")
        c = comments.first
        assert_kind_of Array, comments

        assert File.exists?("poland_com.txt")
        File.open("poland_com.txt") do |f|
          assert_equal "#{c.to_array.join(' ')}\n", f.readline
        end
        File.delete("poland_com.txt")

        comments = FbUtils::Comment.save("http://poland.com", "poland_com", :format => :csv)
        File.open("poland_com.csv") do |f|
          assert_equal "\"#{c.id}\";\"#{c.message}\";\"#{c.from_name}\";\"#{c.from_id}\";\"#{c.created_time}\"\n", f.readline
        end
        File.delete("poland_com.csv")
      end
    end
  end
end