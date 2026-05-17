enum MovieCategory {
  trending('trending', 'Trending This Week'),
  popular('popular', 'Popular Now'),
  upcoming('upcoming', 'Coming Soon'),
  topRated('top_rated', 'Top Rated');

  final String slug;
  final String title;
  const MovieCategory(this.slug, this.title);

  static MovieCategory? fromSlug(String slug) {
    for (final c in MovieCategory.values) {
      if (c.slug == slug) return c;
    }
    return null;
  }
}
