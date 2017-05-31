# encoding: utf-8

class Sanitize
  module Config
    # Sanitize::Config::BLOGGER_HTML
    BLOGGER_HTML = freeze_config(
      elements: %w[
        h2 h3 h4
        a img br

        strong b i em u s sub sup
        font span div p  pre blockquote

        table th tr td
        ul ol li
      ],
      :attributes => {
        'img' => %w[ src title alt width height style ],
        'a'   => %w[ href rel title ],
        'blockquote' => %w[ cite ],
        'table' => %w[ border cellpadding cellspacing width style ],
        'td'    => %w[ align colspan headers rowspan valign width ],
        'th'    => %w[ align colspan headers rowspan valign width ]
      },
      # :add_attributes => {
      #   'a' => { 'rel' => 'nofollow' }
      # },
      :css => {
        :properties => %w[ color margin padding width height ]
      },
      :protocols => {
        'a' => { 'href' => [ 'ftp', 'http', 'https', 'mailto', :relative ] },
        'blockquote' => { 'cite' => [ 'http', 'https', :relative ] }
      }
    )

    # Sanitize::Config::ADMIN_RELAXED
    ADMIN_RELAXED = freeze_config(
      :elements => BASIC[:elements] + %w[
        address article aside bdi bdo body caption col colgroup data del div
        figcaption figure footer h1 h2 h3 h4 h5 h6 head header hgroup hr html
        img ins main nav rp rt ruby section span style summary sup table tbody
        td tfoot th thead title tr wbr iframe
      ],

      :allow_doctype => true,

      :attributes => merge(BASIC[:attributes],
        :all       => %w[class dir hidden id lang style tabindex title translate],
        'a'        => %w[href hreflang name rel target],
        'col'      => %w[span width],
        'colgroup' => %w[span width],
        'data'     => %w[value],
        'del'      => %w[cite datetime],
        'img'      => %w[align alt border height src width],
        'ins'      => %w[cite datetime],
        'li'       => %w[value],
        'ol'       => %w[reversed start type],
        'style'    => %w[media scoped type],
        'table'    => %w[align bgcolor border cellpadding cellspacing frame rules sortable summary width],
        'td'       => %w[abbr align axis colspan headers rowspan valign width],
        'th'       => %w[abbr align axis colspan headers rowspan scope sorted valign width],
        'ul'       => %w[type],
        'iframe'   => %w[src allowfullscreen data-link frameborder height width]
      ),

      :protocols => merge(BASIC[:protocols],
        'del' => {'cite' => ['http', 'https', :relative]},
        'img' => {'src'  => ['http', 'https', :relative]},
        'ins' => {'cite' => ['http', 'https', :relative]}
      ),

      :css => {
        :allow_comments => true,
        :allow_hacks    => true,

        :at_rules  => %w[font-face keyframes media page supports],
        :protocols => ['http', 'https', :relative],

        :properties => %w[
          -moz-appearance
          -moz-background-inline-policy
          -moz-box-sizing
          -moz-column-count
          -moz-column-fill
          -moz-column-gap
          -moz-column-rule
          -moz-column-rule-color
          -moz-column-rule-style
          -moz-column-rule-width
          -moz-column-width
          -moz-font-feature-settings
          -moz-font-language-override
          -moz-hyphens
          -moz-text-align-last
          -moz-text-decoration-color
          -moz-text-decoration-line
          -moz-text-decoration-style
          -ms-background-position-x
          -ms-background-position-y
          -ms-block-progression
          -ms-content-zoom-chaining
          -ms-content-zoom-limit
          -ms-content-zoom-limit-max
          -ms-content-zoom-limit-min
          -ms-content-zoom-snap
          -ms-content-zoom-snap-points
          -ms-content-zoom-snap-type
          -ms-content-zooming
          -ms-filter
          -ms-flex
          -ms-flex-align
          -ms-flex-direction
          -ms-flex-order
          -ms-flex-pack
          -ms-flex-wrap
          -ms-flow-from
          -ms-flow-into
          -ms-grid-column
          -ms-grid-column-align
          -ms-grid-column-span
          -ms-grid-columns
          -ms-grid-row
          -ms-grid-row-align
          -ms-grid-row-span
          -ms-grid-rows
          -ms-high-contrast-adjust
          -ms-hyphenate-limit-chars
          -ms-hyphenate-limit-lines
          -ms-hyphenate-limit-zone
          -ms-hyphens
          -ms-ime-mode
          -ms-interpolation-mode
          -ms-layout-flow
          -ms-layout-grid
          -ms-layout-grid-char
          -ms-layout-grid-line
          -ms-layout-grid-mode
          -ms-layout-grid-type
          -ms-overflow-style
          -ms-overflow-x
          -ms-overflow-y
          -ms-progress-appearance
          -ms-scroll-chaining
          -ms-scroll-limit
          -ms-scroll-limit-x-max
          -ms-scroll-limit-x-min
          -ms-scroll-limit-y-max
          -ms-scroll-limit-y-min
          -ms-scroll-rails
          -ms-scroll-snap-points-x
          -ms-scroll-snap-points-y
          -ms-scroll-snap-type
          -ms-scroll-snap-x
          -ms-scroll-snap-y
          -ms-scroll-translation
          -ms-scrollbar-arrow-color
          -ms-scrollbar-base-color
          -ms-scrollbar-darkshadow-color
          -ms-scrollbar-face-color
          -ms-scrollbar-highlight-color
          -ms-scrollbar-shadow-color
          -ms-scrollbar-track-color
          -ms-text-align-last
          -ms-text-autospace
          -ms-text-justify
          -ms-text-kashida-space
          -ms-text-overflow
          -ms-text-underline-position
          -ms-touch-action
          -ms-user-select
          -ms-word-break
          -ms-word-wrap
          -ms-wrap-flow
          -ms-wrap-margin
          -ms-wrap-through
          -ms-writing-mode
          -ms-zoom
          -webkit-align-content
          -webkit-align-items
          -webkit-align-self
          -webkit-animation
          -webkit-animation-delay
          -webkit-animation-direction
          -webkit-animation-duration
          -webkit-animation-fill-mode
          -webkit-animation-iteration-count
          -webkit-animation-name
          -webkit-animation-play-state
          -webkit-animation-timing-function
          -webkit-appearance
          -webkit-backface-visibility
          -webkit-background-blend-mode
          -webkit-background-clip
          -webkit-background-composite
          -webkit-background-origin
          -webkit-background-size
          -webkit-blend-mode
          -webkit-border-after
          -webkit-border-after-color
          -webkit-border-after-style
          -webkit-border-after-width
          -webkit-border-before
          -webkit-border-before-color
          -webkit-border-before-style
          -webkit-border-before-width
          -webkit-border-bottom-left-radius
          -webkit-border-bottom-right-radius
          -webkit-border-end
          -webkit-border-end-color
          -webkit-border-end-style
          -webkit-border-end-width
          -webkit-border-fit
          -webkit-border-image
          -webkit-border-radius
          -webkit-border-start
          -webkit-border-start-color
          -webkit-border-start-style
          -webkit-border-start-width
          -webkit-border-top-left-radius
          -webkit-border-top-right-radius
          -webkit-box-align
          -webkit-box-decoration-break
          -webkit-box-flex
          -webkit-box-flex-group
          -webkit-box-lines
          -webkit-box-ordinal-group
          -webkit-box-orient
          -webkit-box-pack
          -webkit-box-reflect
          -webkit-box-shadow
          -webkit-box-sizing
          -webkit-clip-path
          -webkit-column-axis
          -webkit-column-break-after
          -webkit-column-break-before
          -webkit-column-break-inside
          -webkit-column-count
          -webkit-column-gap
          -webkit-column-progression
          -webkit-column-rule
          -webkit-column-rule-color
          -webkit-column-rule-style
          -webkit-column-rule-width
          -webkit-column-span
          -webkit-column-width
          -webkit-columns
          -webkit-filter
          -webkit-flex
          -webkit-flex-basis
          -webkit-flex-direction
          -webkit-flex-flow
          -webkit-flex-grow
          -webkit-flex-shrink
          -webkit-flex-wrap
          -webkit-flow-from
          -webkit-flow-into
          -webkit-font-size-delta
          -webkit-grid-area
          -webkit-grid-auto-columns
          -webkit-grid-auto-flow
          -webkit-grid-auto-rows
          -webkit-grid-column
          -webkit-grid-column-end
          -webkit-grid-column-start
          -webkit-grid-definition-columns
          -webkit-grid-definition-rows
          -webkit-grid-row
          -webkit-grid-row-end
          -webkit-grid-row-start
          -webkit-justify-content
          -webkit-line-clamp
          -webkit-logical-height
          -webkit-logical-width
          -webkit-margin-after
          -webkit-margin-after-collapse
          -webkit-margin-before
          -webkit-margin-before-collapse
          -webkit-margin-bottom-collapse
          -webkit-margin-collapse
          -webkit-margin-end
          -webkit-margin-start
          -webkit-margin-top-collapse
          -webkit-marquee
          -webkit-marquee-direction
          -webkit-marquee-increment
          -webkit-marquee-repetition
          -webkit-marquee-speed
          -webkit-marquee-style
          -webkit-mask
          -webkit-mask-box-image
          -webkit-mask-box-image-outset
          -webkit-mask-box-image-repeat
          -webkit-mask-box-image-slice
          -webkit-mask-box-image-source
          -webkit-mask-box-image-width
          -webkit-mask-clip
          -webkit-mask-composite
          -webkit-mask-image
          -webkit-mask-origin
          -webkit-mask-position
          -webkit-mask-position-x
          -webkit-mask-position-y
          -webkit-mask-repeat
          -webkit-mask-repeat-x
          -webkit-mask-repeat-y
          -webkit-mask-size
          -webkit-mask-source-type
          -webkit-max-logical-height
          -webkit-max-logical-width
          -webkit-min-logical-height
          -webkit-min-logical-width
          -webkit-opacity
          -webkit-order
          -webkit-padding-after
          -webkit-padding-before
          -webkit-padding-end
          -webkit-padding-start
          -webkit-perspective
          -webkit-perspective-origin
          -webkit-perspective-origin-x
          -webkit-perspective-origin-y
          -webkit-region-break-after
          -webkit-region-break-before
          -webkit-region-break-inside
          -webkit-region-fragment
          -webkit-shape-inside
          -webkit-shape-margin
          -webkit-shape-outside
          -webkit-shape-padding
          -webkit-svg-shadow
          -webkit-tap-highlight-color
          -webkit-text-decoration
          -webkit-text-decoration-color
          -webkit-text-decoration-line
          -webkit-text-decoration-style
          -webkit-touch-callout
          -webkit-transform
          -webkit-transform-origin
          -webkit-transform-origin-x
          -webkit-transform-origin-y
          -webkit-transform-origin-z
          -webkit-transform-style
          -webkit-transition
          -webkit-transition-delay
          -webkit-transition-duration
          -webkit-transition-property
          -webkit-transition-timing-function
          -webkit-user-drag
          -webkit-wrap-flow
          -webkit-wrap-through
          align-content
          align-items
          align-self
          animation
          animation-delay
          animation-direction
          animation-duration
          animation-fill-mode
          animation-iteration-count
          animation-name
          animation-play-state
          animation-timing-function
          backface-visibility
          background
          background-attachment
          background-clip
          background-color
          background-image
          background-origin
          background-position
          background-repeat
          background-size
          border
          border-bottom
          border-bottom-color
          border-bottom-left-radius
          border-bottom-right-radius
          border-bottom-style
          border-bottom-width
          border-collapse
          border-color
          border-image
          border-image-outset
          border-image-repeat
          border-image-slice
          border-image-source
          border-image-width
          border-left
          border-left-color
          border-left-style
          border-left-width
          border-radius
          border-right
          border-right-color
          border-right-style
          border-right-width
          border-spacing
          border-style
          border-top
          border-top-color
          border-top-left-radius
          border-top-right-radius
          border-top-style
          border-top-width
          border-width
          bottom
          box-decoration-break
          box-shadow
          box-sizing
          break-after
          break-before
          break-inside
          caption-side
          clear
          clip
          clip-path
          color
          column-count
          column-fill
          column-gap
          column-rule
          column-rule-color
          column-rule-style
          column-rule-width
          column-span
          column-width
          columns
          content
          counter-increment
          counter-reset
          cursor
          direction
          display
          empty-cells
          filter
          flex
          flex-basis
          flex-direction
          flex-flow
          flex-grow
          flex-shrink
          flex-wrap
          float
          font
          font-family
          font-feature-settings
          font-kerning
          font-language-override
          font-size
          font-size-adjust
          font-stretch
          font-style
          font-synthesis
          font-variant
          font-variant-alternates
          font-variant-caps
          font-variant-east-asian
          font-variant-ligatures
          font-variant-numeric
          font-variant-position
          font-weight
          height
          hyphens
          icon
          image-orientation
          image-rendering
          image-resolution
          ime-mode
          justify-content
          left
          letter-spacing
          line-height
          list-style
          list-style-image
          list-style-position
          list-style-type
          margin
          margin-bottom
          margin-left
          margin-right
          margin-top
          marks
          mask
          mask-type
          max-height
          max-width
          min-height
          min-width
          object-fit
          object-position
          opacity
          order
          orphans
          outline
          outline-color
          outline-offset
          outline-style
          outline-width
          overflow
          overflow-wrap
          overflow-x
          overflow-y
          padding
          padding-bottom
          padding-left
          padding-right
          padding-top
          page-break-after
          page-break-before
          page-break-inside
          perspective
          perspective-origin
          position
          quotes
          resize
          right
          tab-size
          table-layout
          text-align
          text-align-last
          text-combine-horizontal
          text-decoration
          text-decoration-color
          text-decoration-line
          text-decoration-style
          text-indent
          text-orientation
          text-overflow
          text-rendering
          text-shadow
          text-transform
          text-underline-position
          top
          touch-action
          transform
          transform-origin
          transform-style
          transition
          transition-delay
          transition-duration
          transition-property
          transition-timing-function
          unicode-bidi
          unicode-range
          vertical-align
          visibility
          white-space
          widows
          width
          word-break
          word-spacing
          word-wrap
          writing-mode
          z-index
        ]
      }
    )
  end
end
