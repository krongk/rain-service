module PhoneCallsHelper

  def get_pcall_form_code(user_id)
    %{
      <form accept-charset="UTF-8" action="/phone_calls" class="simple_form new_phone_call" id="new_phone_call" method="post" novalidate="novalidate">
        <input name="utf8" type="hidden" value="&#x2713;" />
        <input name="authenticity_token" type="hidden" value="ZwjbDEeCe11AxpxwpvvZrFsxwqgnSc97kRAg0vf1wms=" />
        <input class="hidden" id="phone_call_domain" name="phone_call[domain]" type="hidden" /></div></div>
        <input class="hidden" id="phone_call_from_ip" name="phone_call[from_ip]" type="hidden" /></div></div>
        <input class="hidden" id="phone_call_from_url" name="phone_call[from_url]" type="hidden" /></div></div>
        <div class="control-group tel optional phone_call_from_phone">
          <label class="tel optional control-label" for="phone_call_from_phone">From phone</label>
          <div class="controls">
            <input class="string tel optional" id="phone_call_from_phone" name="phone_call[from_phone]" type="tel" />
            <input class="btn btn-primary btn-large" data-disable-with="正在提交..." name="commit" type="submit" value="提交" />
          </div>
        </div>
      </form>
    }
  end
end

