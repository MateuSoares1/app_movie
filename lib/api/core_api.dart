import 'package:dio/dio.dart';

const String kBaseUrl = 'https://api.themoviedb.org/3';
const String kApiKey =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkZTliNTFiMDJkY2VkNzdkMzJjNDgxMzBiMDRhYjNjMCIsInN1YiI6IjYxYzYxZTJiZDg2MWFmMDA1ZWU0NmZlMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.OXZs_2Ruyud6WF5gt4TTu7rHMA1JwU_iiUikX6pgoQM';

final BaseOptions kBaseClientOptions = BaseOptions(
  baseUrl: kBaseUrl,
  queryParameters: {'language': 'pt-BR'},
  contentType: 'application/json;charset=utf-8',
  headers: {'Authorization': 'Bearer $kApiKey'},
);