# EZRatingView

**This project is derivative from the original [AXRatingView](https://github.com/akiroom/AXRatingView), which now is maintained by myself. Feature Requests and PR are welcome.**

- __Backward Compatibility Information__
  - 2.0.0 -> 1.x.x
    - All the configuration to the slider moved from properties to ```markerDict```

  - 0.x.x -> 1.x.x
    - UIControlEventValueChanged is triggered on control changing (See [#13](https://github.com/akiroom/AXRatingView/pull/13/))
    
## Marker Customization Dictionary Settings

|Key|Type|Description|Note|
|---|---|---|---|
|EZMarkerMaskCharacterKey|NSString|Normal marker character will be using|Required if no value of `EZMarkerMaskImageKey` present|
|EZMarkerHighlightCharacterKey|NSString|Highlight marker character will be using, same as `EZMarkerMaskCharacterKey` if not provided|Optional|
|EZMarkerCharacterFontKey|UIFont|Marker character size will be using, `[UIFont systemFontOfSize:22.0]` will be used if not provided|Optional|
|EZMarkerMaskImageKey|UIImage|Normal marker image will be using|Required if no value of `EZMarkerMaskCharacterKey` present|
|EZMarkerHighlightImageKey|UIImage|Highlight marker image will be using, same as `EZMarkerMaskImageKey` if not provided|Optional|
|EZMarkerBaseColorKey|UIColor|Normal marker color will be using, `[UIColor darkGrayColor]` will be used if not provided|Optional|
|EZMarkerHighlightColorKey|UIColor|Highlight marker color will be using, `[UIColor colorWithRed:1.0 green:0.8 blue:0.0 alpha:1.0]` will be used if not provided|Optional|

If both `EZMarkerMaskImageKey` and `EZMarkerMaskCharacterKey` values are provided, `EZMarkerMaskImageKey` will be the first prioritized to use. 

## About
Star mark rating view for a review scene.

- Smooth rating (ex. 4.22 -> 4.23)
- Step rating by 1.0 (ex. 3.00 -> 4.00)
- Step rating by 0.5 (ex. 3.00 -> 3.50 -> 4.00)
- Set other unicode character (not star character)
- Set image
- Set color
- Editable & Not Editable
- Easy to Get/Set.
- Compatibility for iOS6, iOS7, iOS8

## Screenshots
### iOS7

![iOS7 Screenshot](https://raw.github.com/EvianZhow/EZRatingView/master/EZRatingViewDemo/Screenshot.png)

### iOS6

![iOS6 Screenshot](https://raw.github.com/EvianZhow/EZRatingView/master/EZRatingViewDemo/Screenshot-iOS6.png)

# Development

Using `.clang-format` under EZRatingViewDemo directory to format the code. 
