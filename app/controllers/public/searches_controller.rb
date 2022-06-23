class Public::SearchesController < ApplicationController

  def search
    @range = params[:range]
    @content = params[:content]
    @method = params[:method]
    if @content != ""
      # 会員検索
      if @range == 'member'
        @records = Member.search_for(@content, @method).recent_member.page(params[:page])
      # 作品タイトル検索
      elsif @range == 'post_title'
        @range_ja = "作品タイトル"
        @records = Post.search_title_for(@content, @method).recent.page(params[:page])
      # 作品説明検索
      elsif @range == 'post_explanation'
        @range_ja = "作品説明"
        @records = Post.search_explanation_for(@content, @method).recent.page(params[:page])
      # タグ検索
      elsif @range == 'tag'
        @records = Tag.search_for(@content, @method).recent.page(params[:page])
      end
    else
      flash[:alert] = "検索ワードを入力してください"
      redirect_to request.referer
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
