class Api::V1::DoraemonController < ApplicationController
    require 'net/http'
    require 'nokogiri'
    require 'uri'
    skip_before_action :authenticate_request, only: [:html]

    def doraemon
        if params[:msg]
            msg = params[:msg]
            client = OpenAI::Client.new(access_token: ENV['API_KEY'])
            
            res = client.chat(
            parameters: {
                model: "gpt-3.5-turbo",
                messages: [{ 'role' => 'system', 'content' => 'あなたはドラえもんです。以下の命令を全て守って返事してください。「です」、「ます」などの敬語を使わないでください。返答は「のび太くん！」から始めてください。語尾は、「〇〇だよ！」や「〇〇なんだ！」のような話し方でお願いします。友達に接するように、フランクに話してください。一人称は「ぼく」にしてください。回答は50文字をこえないように答えてください。' },{ 'role' => 'user', 'content' => msg }],
                max_tokens: 100
            })

            puts res.dig('choices', 0, 'message', 'content')
            @word = res.dig('choices', 0, 'message', 'content').gsub(/[\r\n]/,"")

            respond_to do |format|
                format.html
                format.js
            end
        end
    end

    

    def html
        if params[:url].blank?
            return render json: { error: "No URL provided." }, status: :unprocessable_entity
        end

        begin
            uri = URI.parse(params[:url])
            # URIが正しくない場合、URI.parseはURI::InvalidURIErrorを発生させる
            response = Net::HTTP.get_response(uri)
        rescue URI::InvalidURIError
            return render json: { error: "Invalid URL format." }, status: :bad_request
        rescue => e
            return render json: { error: "Error fetching URL: #{e.message}" }, status: :bad_request
        end

        if response.is_a?(Net::HTTPSuccess)
            doc = Nokogiri::HTML(response.body)
            if doc.at('body').nil?
                return render json: { error: "No body tag found in HTML." }, status: :bad_request
            end
            text_content = doc.at('body').text
            clean_text = clean_up_text(text_content)
            summarized_text = chatgpt(clean_text)  # 仮定のメソッドを呼び出し
            render json: { text: summarized_text }, status: :ok
        else
            render json: { error: "Failed to fetch HTML from the URL. Status: #{response.code}" }, status: :bad_request
        end
    end

    private

    def clean_up_text(text)
        # JavaScriptコードや特定のフッターテキストを削除
        pattern = /(document\.addEventListener|©|\/* \[CDATA\[|All rights reserved).*/im
        text.gsub(pattern, '').gsub(/\s+/, ' ').strip
    end

    def chatgpt(text)
        client = OpenAI::Client.new(access_token: ENV['API_KEY'])
            
        res = client.chat(
        parameters: {
            model: "gpt-3.5-turbo",
            messages: [{ 'role' => 'system', 'content' => 'あなたは要約のプロです。受け取った文章を200字程度に要約してください。' },{ 'role' => 'user', 'content' => text }],
            max_tokens: 500
        })
        res.dig('choices', 0, 'message', 'content').gsub(/[\r\n]/,"")
    end
end
