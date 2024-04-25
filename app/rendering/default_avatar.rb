module DefaultAvatar
  class Internal
    # foreground and background color combinations with good contrast
    COLOR_COMBOS = [
      %w[#00f #fff],
      %w[#f00 #fff],
      %w[#0f0 #fff],
      %w[#ff0 #000],
      %w[#f0f #fff],
      %w[#0ff #000],
      %w[#000 #fff],
      %w[#fff #000]
    ]

    def user_initial(user)
      major_initial =
        [user.name, user.email].select(&:present?)
          .map(&:first)
          .map(&:upcase)
          .select { _1 =~ /[A-Z0-9]/ }
          .first

      major_initial || '?'
    end

    # A consistent color combination based on user
    def color_combo(user)
      COLOR_COMBOS[user.id % COLOR_COMBOS.size]
    end

    def output(user)
      fg, bg = color_combo(user)
      initial = user_initial(user)

      <<~EOS
      <svg viewBox="0 0 120 120">
        <g transform="translate(60,60)">
          <circle cx="0" cy="0" r="50"
           stroke="#aaa" stroke-width="2" fill="#{bg}" />
          <text x="0" y="0" alignment-baseline="middle"
           font-size="30px" stroke-width="1" stroke="#{fg}"
           fill="#{fg}" text-anchor="middle">
           #{initial}
          </text>
        </g>
      </svg>
      EOS
    end
  end

  module_function

  def for(user)
    Internal.new.output user
  end
end
