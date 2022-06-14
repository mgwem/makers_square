class Public::SearchesController < ApplicationController
  def search
    @range = params[:range]
    @content = params[:content]
    @method = params[:method]
    if @range == 'member'
      @records = Member.search_for(@content, @method).page(params[:page]).order(id: :DESC)
    elsif @range == 'post_title'
      @records = Post.search_for_title(@content, @method).page(params[:page]).order(id: :DESC)
    else
      @records = Post.search_for_explanation(@content, @method).page(params[:page]).order(id: :DESC)
    end
  end
end
