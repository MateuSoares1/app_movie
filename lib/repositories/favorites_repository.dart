import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/auth_service.dart';
import 'package:movie_app/utils/firestore_collections_keys.dart';

class FavoritesRepository {
  Future<List<MovieModel>> fetchFavoriteMovies() async {
    final List<MovieModel> moviesList = [];
    final snapshot = await FirebaseFirestore.instance
        .collection(
          FirestoreCollectionsKeys.users,
        )
        .doc(AuthService().user?.uid)
        .collection(FirestoreCollectionsKeys.favoriteMoviesSubcollection)
        .get();

    for (var doc in snapshot.docs) {
      moviesList.add(MovieModel.fromMap(doc.data()));
    }

    return moviesList;
  }

  Future<bool> addMovieToFavorites({required MovieModel movie}) async {
    final result = await FirebaseFirestore.instance
        .collection(
          FirestoreCollectionsKeys.users,
        )
        .doc(AuthService().user?.uid)
        .collection(FirestoreCollectionsKeys.favoriteMoviesSubcollection)
        .doc(movie.id.toString())
        .set(movie.toMap())
        .then(
          (_) => true,
          onError: (_) => false,
        );

    return result;
  }

  Future<bool> removeMovieFromFavorites({required MovieModel movie}) async {
    final result = await FirebaseFirestore.instance
        .collection(
          FirestoreCollectionsKeys.users,
        )
        .doc(AuthService().user?.uid)
        .collection(FirestoreCollectionsKeys.favoriteMoviesSubcollection)
        .doc(movie.id.toString())
        .delete()
        .then(
          (_) => true,
          onError: (_) => false,
        );

    return result;
  }

  Future<bool> isMovieInFavorites({required int movieId}) async {
    final result = await FirebaseFirestore.instance
        .collection(
          FirestoreCollectionsKeys.users,
        )
        .doc(AuthService().user?.uid)
        .collection(FirestoreCollectionsKeys.favoriteMoviesSubcollection)
        .doc(movieId.toString())
        .get();

    return result.exists;
  }
}
