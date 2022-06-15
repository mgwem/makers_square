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
    # @method日本語表記
    if @method == 'perfect'
      @method_ja = "完全一致"
    elsif @method == 'forward'
      @method_ja = "前方一致"
    elsif @method == 'backward'
      @method_ja = "後方一致"
    else
      @method_ja = "部分一致"
    end
  end
end
