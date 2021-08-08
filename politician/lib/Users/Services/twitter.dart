import 'package:dart_twitter_api/twitter_api.dart';

final twitterApi = TwitterApi(
  client: TwitterClient(
      consumerKey: 'AamqD9L2203GV70hl8LBSxCCd',
      consumerSecret: '0MbJZ2KcPwybxBEELvlXMJjkZTyFvQ7gLbLXh2ra5z60Wj2ASU',
      token: '1419579285786955776-2il6uN6KC7dr3gNCqHLkqTVwIrRi5r',
      secret: 'WV53Wl5XQpreS02itxPm41N9e9mrSGW3HXGxZIUSWF4mr'
  ),
);

Future Twittercall() async {
  try {
    final homeTimeline = await twitterApi.timelineService.userTimeline(
        userId: "85221650",
        count: 200
    );
    return homeTimeline;
  } catch (error) {
    print('error while requesting home timeline: $error');
  }
}
