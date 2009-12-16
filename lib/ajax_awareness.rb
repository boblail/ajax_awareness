# Special methods to help controllers handle (and differentiate)
# XHR requests  and standard requests DRYly.
module AjaxAwareness

  def xhr_aware_redirect_to(*args)
    if request.xhr?
      render :update do |page|
        page.redirect_to *args
      end
    else
      # super
      redirect_to *args
    end
  end

  # todo: deprecate?
  def popup_or_redirect_to(*args)
    if request.xhr?
      url = args.first
      url = url_for(url) if url.is_a?(Hash)
      render :update do |page|
        page.call "ModalPopup.show", "{url:'#{url}'}"
      end
    else
      redirect_to *args
    end
  end

  def refresh(id, *args)
    if request.xhr?
      render :update do |page|
        page.replace_html id, *args
      end
    else
      render *args
    end
  end

  def xhr_aware_render(*args)
    # puts "request.xhr?: #{request.xhr?}"
    if request.xhr?
      # options = args.extract_options!
      # options[:layout] = false
      # todo: ?
      render :layout => false
    else
      render *args
    end
  end

end