class Public::SearchesController < ApplicationController
  def search
    @range = params[:range]
    @content = params[:content]
    @method = params[:method]
    if @range == 'member'
      @records = Member.search_for(@content, @method).recent_member.page(params[:page])
    elsif @range == 'post_title'
      @range_ja = "作品タイトル"
      @records = Post.search_title_for(@content, @method).recent.page(params[:page])
    elsif @range == 'post_explanation'
      @range_ja = "作品説明"
      @records = Post.search_explanation_for(@content, @method).recent.page(params[:page])
    elsif @range == 'tag'
      tags = Tag.search_for(@content, @method).reverse
      @records = Kaminari.paginate_array(tags).page(params[:page])
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
