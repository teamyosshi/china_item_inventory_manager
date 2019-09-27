# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# ページネーション ラベル日本語化
WillPaginate::ViewHelpers.pagination_options[:previous_label] = '前へ'
WillPaginate::ViewHelpers.pagination_options[:next_label] = '次へ'