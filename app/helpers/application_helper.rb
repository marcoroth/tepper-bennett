module ApplicationHelper

  def external_link(text, url)
    tag.a(text, href:url, target: '_blank').html_safe
  end


  def li_external_link(text, url)
    tag.li(external_link(text.html_safe, url)).html_safe
  end


  def validate_artist_or_movie(artist_or_movie)
    unless %i(artist movie).include?(artist_or_movie)
      raise "Invalid symbol: #{artist_or_movie}. Must be :artist or :movie."
    end
  end


  # Outputs the <tr> for a table row, with either the artist or the movie occupying the 2nd column,
  # depending on the 2nd argument, :artist or :movie.
  def song_table_row(recording, artist_or_movie)
    validate_artist_or_movie(artist_or_movie)
    artist_or_title_value = (artist_or_movie == :artist) ? recording.artist : recording.movie
    url = recording.embed_url

    html = <<HEREDOC
    <tr>
      <td>#{recording.title}</td>
      <td>#{artist_or_title_value}</td>
      <td align="center">
        <a class="image-cell youtube-view" data-toggle="modal" data-target="#youTubeViewerModal"
          data-url="#{url}"
        />
          #{image_tag('youtube.png', alt: 'Listen')}
        </a>
      </td>
    </tr>
HEREDOC
    html.html_safe
  end


def song_table(artist_or_movie)
  validate_artist_or_movie(artist_or_movie)
  heading = artist_or_movie.capitalize
  recordings = artist_or_movie == :artist ? @recordings : @elvis_recordings
  recordings_html = recordings.map { |r| song_table_row(r, artist_or_movie) }.join("\n")

  html = <<HEREDOC
    <div class="table-responsive">
      <table class="data-table table thead-dark table-striped">
        <thead class="thead-dark">
        <tr>
          <th>Title</th>
          <th>#{heading}</th>
          <th style="text-align: center;">Listen</th>
        </tr>
        </thead>
        <tbody>
          #{recordings_html}
        </tbody>
      </table>
    </div>

HEREDOC

  html.html_safe
end


  def inspect(object)
    object.ai(html: true, plain:true, multiline: true)
  end

  def youtube_text_song_link(text, youtube_code)
    html = tag.a(
        href: '#',
        class: "youtube-view",
        'data-url'.to_sym => SongPlay.youtube_embed_url(youtube_code),
        'data-toggle'.to_sym => 'modal',
        'data-target'.to_sym => '#youTubeViewerModal') do
      text
    end
    html.html_safe
  end
end
